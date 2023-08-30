# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT84 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1eb016252311214302c09b508faddaf02cb70b01e3d971bf6c0e6e2cb9e7743e"
    sha256 cellar: :any,                 arm64_big_sur:  "977688e325e4a104c951a3919b29676e0c592cc8180d1286b22b0563295bd301"
    sha256 cellar: :any,                 ventura:        "3701f4835630972677d3b3125669b6e08b3c97d9886165a4624830c06ccccd01"
    sha256 cellar: :any,                 monterey:       "0490c8a64a606f0b49d20ebe852c1992926b53d38822d1da2743d49347a5cb5e"
    sha256 cellar: :any,                 big_sur:        "ae05d7e85ed87f35fc4f5278a1776ff383ca2c81f301182e6bccdccb8a9db40c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49d0b00c480a4a29bfeb038a022b0e387959bbf4e49d972712cf5553302b4ce1"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
