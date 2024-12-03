# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a280bbf377e3926cd68960065dcbdf387dda812.tar.gz"
  version "5.6.40"
  sha256 "4709aa659ca0ec0033c3743c8083c2331a36334e56dade3a6c43983c240bcbc5"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any,                 arm64_sequoia:  "2dce87749a387b4c93a369be84be05d972055e8a81bcc3247eb9168b98bc5b3d"
    sha256 cellar: :any,                 arm64_sonoma:   "9fbd6bd8d8f164c6280a947ac8e5c7e5adf315c788fc4576e5193d0883503acb"
    sha256 cellar: :any,                 arm64_ventura:  "04a6ca5fd2717468a11b0fa6ae41f7521e21418291f9739e240c5748885a9cad"
    sha256 cellar: :any,                 arm64_monterey: "e95552c179a7d996f0b67ae639e23bb08fdaa78d6961957c251f5a38735cabc5"
    sha256 cellar: :any,                 ventura:        "debe442f28f8d32513f2b87a498d0b8adbe8108e0fc7364ecce5d635db2d78b1"
    sha256 cellar: :any,                 monterey:       "bed2289a7f14a1ec70dcde64b3242a534e8064dd995afa50f5e7a3f7f6a845cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e9172346785013d2558707afb81893606b9ba88891c97eaac3555444d0c97567"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    ENV.append "CFLAGS", "-Wno-implicit-int"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
