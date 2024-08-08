# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/de417b2a04e4bc04f59e3a214ac2158f8becdc4f.tar.gz"
  version "5.6.40"
  sha256 "897fe10215996e84b9db1f2a4cf9f1d11fd0ba70151e74e5adc780aebf07f2b8"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "c1ac88efedb3993eaf3fd33dd1f051e6604ec79a8ea305956520b438a0de9c85"
    sha256 cellar: :any,                 arm64_ventura:  "4227a93b6cd32b07f4aab56f9dae6ffba780ebb2a43f34a2a72f08c01473d303"
    sha256 cellar: :any,                 arm64_monterey: "1963c8130f45c33bfda2bbfe8022b16569d5a1ffb1f8b2c53745900e07b22a85"
    sha256 cellar: :any,                 ventura:        "1b1dcc479b876e8f0aaf6eb18b40c75689f866263169d948fd3660413fd8efc4"
    sha256 cellar: :any,                 monterey:       "f903a7348a60aabf78cdff578a22463f32eb62a1ef39f0259c182d523369e100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9da60aa0ac201c13a633347d72b8835e5b20ccb149d96c9a56b0005a828c7312"
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
