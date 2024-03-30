class OpenMpi < Formula
  desc "High performance message passing library"
  homepage "https://www.open-mpi.org/"
  url "https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.2.tar.bz2"
  sha256 "ee46ad8eeee2c3ff70772160bff877cbf38c330a0bc3b3ddc811648b3396698f"
  license "BSD-3-Clause"
  revision 1

  livecheck do
    url :homepage
    regex(/MPI v?(\d+(?:\.\d+)+) release/i)
  end

  bottle do
    sha256 arm64_sonoma:   "da69dec8c6b43128266db395acde65fea82566a27ac477bd75ef423835143519"
    sha256 arm64_ventura:  "eb89f6e53fd470318443d0534db916478ffd019a31f648cf39211f2671ae63ec"
    sha256 arm64_monterey: "f054a55d31b483af38930d278d861b30e118cb5d30f13efa834c32502a2cffc2"
    sha256 sonoma:         "1856a7edf82c6f5fe6a120cfc2d2145521bd8f5d6bfbdfc79a4775a6d9095e00"
    sha256 ventura:        "717237e8d98a7062c24585f3aae94834be70e3426e5505ea2a8c827ca339239d"
    sha256 monterey:       "d0f14f4b79fa8d89754aec58701e190e2bc4c3c45ce2e0406f998e61abd8af25"
    sha256 x86_64_linux:   "740d0e8b41f30312c59aee85e30fbafa6ddcd380793f1900bc6a10be0d4fc30d"
  end

  head do
    url "https://github.com/open-mpi/ompi.git", branch: "main"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "gcc" # for gfortran
  depends_on "hwloc"
  depends_on "libevent"
  depends_on "pmix"

  conflicts_with "mpich", because: "both install MPI compiler wrappers"

  def install
    if OS.mac?
      # Otherwise libmpi_usempi_ignore_tkr gets built as a static library
      ENV["MACOSX_DEPLOYMENT_TARGET"] = MacOS.version

      # Work around asm incompatibility with new linker (FB13194320)
      # https://github.com/open-mpi/ompi/issues/11935
      ENV.append "LDFLAGS", "-Wl,-ld_classic" if DevelopmentTools.clang_build_version >= 1500
    end

    # Avoid references to the Homebrew shims directory
    inreplace_files = %w[
      ompi/tools/ompi_info/param.c
      oshmem/tools/oshmem_info/param.c
    ]
    inreplace_files_cc = %w[
      3rd-party/openpmix/src/tools/pmix_info/support.c
      3rd-party/prrte/src/tools/prte_info/param.c
    ]

    cxx = OS.linux? ? "g++" : ENV.cxx
    inreplace inreplace_files, "OMPI_CXX_ABSOLUTE", "\"#{cxx}\""

    cc = OS.linux? ? "gcc" : ENV.cc
    inreplace inreplace_files, /(OPAL|PMIX)_CC_ABSOLUTE/, "\"#{cc}\""
    inreplace inreplace_files_cc, /(PMIX|PRTE)_CC_ABSOLUTE/, "\"#{cc}\""

    ENV.cxx11
    ENV.runtime_cpu_detection

    args = %W[
      --disable-silent-rules
      --enable-ipv6
      --enable-mca-no-build=reachable-netlink
      --sysconfdir=#{etc}
      --with-hwloc=#{Formula["hwloc"].opt_prefix}
      --with-libevent=#{Formula["libevent"].opt_prefix}
      --with-pmix=#{Formula["pmix"].opt_prefix}
      --with-sge
    ]
    args << "--with-platform-optimized" if build.head?

    # Work around asm incompatibility with new linker (FB13194320)
    # https://github.com/open-mpi/ompi/issues/11935
    args << "--with-wrapper-ldflags=-Wl,-ld_classic" if DevelopmentTools.clang_build_version >= 1500

    system "./autogen.pl", "--force" if build.head?
    system "./configure", *std_configure_args, *args
    system "make", "all"
    system "make", "check"
    system "make", "install"

    # Fortran bindings install stray `.mod` files (Fortran modules) in `lib`
    # that need to be moved to `include`.
    include.install lib.glob("*.mod")

    # Avoid references to cellar paths.
    inreplace (lib/"pkgconfig").glob("*.pc"), prefix, opt_prefix, false
  end

  test do
    (testpath/"hello.c").write <<~EOS
      #include <mpi.h>
      #include <stdio.h>

      int main()
      {
        int size, rank, nameLen;
        char name[MPI_MAX_PROCESSOR_NAME];
        MPI_Init(NULL, NULL);
        MPI_Comm_size(MPI_COMM_WORLD, &size);
        MPI_Comm_rank(MPI_COMM_WORLD, &rank);
        MPI_Get_processor_name(name, &nameLen);
        printf("[%d/%d] Hello, world! My name is %s.\\n", rank, size, name);
        MPI_Finalize();
        return 0;
      }
    EOS
    system bin/"mpicc", "hello.c", "-o", "hello"
    system "./hello"
    system bin/"mpirun", "./hello"
    (testpath/"hellof.f90").write <<~EOS
      program hello
      include 'mpif.h'
      integer rank, size, ierror, tag, status(MPI_STATUS_SIZE)
      call MPI_INIT(ierror)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
      print*, 'node', rank, ': Hello Fortran world'
      call MPI_FINALIZE(ierror)
      end
    EOS
    system bin/"mpifort", "hellof.f90", "-o", "hellof"
    system "./hellof"
    system bin/"mpirun", "./hellof"

    (testpath/"hellousempi.f90").write <<~EOS
      program hello
      use mpi
      integer rank, size, ierror, tag, status(MPI_STATUS_SIZE)
      call MPI_INIT(ierror)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierror)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierror)
      print*, 'node', rank, ': Hello Fortran world'
      call MPI_FINALIZE(ierror)
      end
    EOS
    system bin/"mpifort", "hellousempi.f90", "-o", "hellousempi"
    system "./hellousempi"
    system bin/"mpirun", "./hellousempi"

    (testpath/"hellousempif08.f90").write <<~EOS
      program hello
      use mpi_f08
      integer rank, size, tag, status(MPI_STATUS_SIZE)
      call MPI_INIT()
      call MPI_COMM_SIZE(MPI_COMM_WORLD, size)
      call MPI_COMM_RANK(MPI_COMM_WORLD, rank)
      print*, 'node', rank, ': Hello Fortran world'
      call MPI_FINALIZE()
      end
    EOS
    system bin/"mpifort", "hellousempif08.f90", "-o", "hellousempif08"
    system "./hellousempif08"
    system bin/"mpirun", "./hellousempif08"
  end
end
