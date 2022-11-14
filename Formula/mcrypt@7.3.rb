# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT73 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
  sha256 "c9f51e211640a15d2a983f5d80e26660656351651d6f682d657bdf1cfa07d8a3"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b72d82b87d0e586ed4edd58ce09f50978b0c9b078a8a0701d97064d8b8d4c0b6"
    sha256 cellar: :any,                 arm64_big_sur:  "7e257ee8a1d66afdeb8f9a7c78276fe188b19d5dac14e786cdd4d7e8012207a2"
    sha256 cellar: :any,                 monterey:       "b47606725d649365c2bcebefd5bd07cfef95232b1c410955da46ce87368efb8a"
    sha256 cellar: :any,                 big_sur:        "d3de8ef9645620c05b3543565a041689dffc0e41d37bd975a960ac3e4086d0ed"
    sha256 cellar: :any,                 catalina:       "8fe30e856c312afd9717123582b605dd2c713cc573dbeab794c29b05295f563e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd85d6d76dca051645bed423847c1cbbdc8d59a9792cc6917ccb009598d0e921"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
