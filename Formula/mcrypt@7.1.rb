# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f12d05c0fdf5c88c94d8d54fa1f925aae6e302a6.tar.gz"
  version "7.1.33"
  sha256 "3153fd11bee1ff291c9367c9544f12b3df2070bba97420a12c835505ff7000ea"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "0df608afb04ab63bc94aa89b10bb3e6b142da3d21559d7051e4c09b2852b260a"
    sha256 cellar: :any,                 arm64_big_sur:  "19fbe2335982d2fa77f27ff115fe1048f000bc2c226995e162be51b897793d80"
    sha256 cellar: :any,                 ventura:        "8f9d133444dae2277b7fefaf842a830782aa21bd35437c67e1378e38a02b6822"
    sha256 cellar: :any,                 monterey:       "5efee6c9178fb0aade3da8d4c3225aa228c7e7ba50b5bce0c9fc49a640073c13"
    sha256 cellar: :any,                 big_sur:        "530df95a88e16dbd21d7cf013d8e3a640952e6a279ec3a303b8766782adeb76c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9117ed164bfb2b5dabd186f2438200849ab4b1af743d5f5049cd1d03da0b0e2"
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
