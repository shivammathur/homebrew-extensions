class Libtool < Formula
  desc "Generic library support script"
  homepage "https://www.gnu.org/software/libtool/"
  url "https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.xz"
  mirror "https://ftpmirror.gnu.org/libtool/libtool-2.4.7.tar.xz"
  sha256 "4f7f217f057ce655ff22559ad221a0fd8ef84ad1fc5fcb6990cecc333aa1635d"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "340b9fbf2269cecb88e577fa3aa7b176c3d49ef41eb3554ffeb0c35f0c0993af"
    sha256 cellar: :any,                 arm64_ventura:  "0460265825de454568c55d6489ed8eb85297815a1f1ab37f2dafea5fd4414818"
    sha256 cellar: :any,                 arm64_monterey: "f8d612f923986ac31e852356353e6b0caf7b607cca5fe18ef4487c8f118258c3"
    sha256 cellar: :any,                 sonoma:         "443df5cc0b5333bf99339d2c93e1c4e28ab38a07babd46b1bfa561aa364a5075"
    sha256 cellar: :any,                 ventura:        "079d5187a97c87b14bafa3e63d31b8c15338b09cae2ccd006538d3df46676279"
    sha256 cellar: :any,                 monterey:       "ac3d1ccd5595e489d6b8185eb93c985a7f955e3b50057a5370678a911371ca58"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "450ce5348079f2ad8dff146ca5c28a725b397ec4a7b3effb2090235ef9a61f67"
  end

  depends_on "m4"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-ltdl-install
    ]

    args << "--program-prefix=g" if OS.mac?

    system "./configure", *args
    system "make", "install"

    if OS.mac?
      %w[libtool libtoolize].each do |prog|
        (libexec/"gnubin").install_symlink bin/"g#{prog}" => prog
        (libexec/"gnuman/man1").install_symlink man1/"g#{prog}.1" => "#{prog}.1"
      end
      (libexec/"gnubin").install_symlink "../gnuman" => "man"
    end

    if OS.linux?
      bin.install_symlink "libtool" => "glibtool"
      bin.install_symlink "libtoolize" => "glibtoolize"

      # Avoid references to the Homebrew shims directory
      inreplace bin/"libtool", Superenv.shims_path, "/usr/bin"
    end
  end

  def caveats
    on_macos do
      <<~EOS
        All commands have been installed with the prefix "g".
        If you need to use these commands with their normal names, you
        can add a "gnubin" directory to your PATH from your bashrc like:
          PATH="#{opt_libexec}/gnubin:$PATH"
      EOS
    end
  end

  test do
    system "#{bin}/glibtool", "execute", File.executable?("/usr/bin/true") ? "/usr/bin/true" : "/bin/true"
    (testpath/"hello.c").write <<~EOS
      #include <stdio.h>
      int main() { puts("Hello, world!"); return 0; }
    EOS
    system bin/"glibtool", "--mode=compile", "--tag=CC",
      ENV.cc, "-c", "hello.c", "-o", "hello.o"
    system bin/"glibtool", "--mode=link", "--tag=CC",
      ENV.cc, "hello.o", "-o", "hello"
    assert_match "Hello, world!", shell_output("./hello")
  end
end
