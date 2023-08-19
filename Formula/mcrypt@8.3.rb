# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ad352235dad40564d3d8243129c09eb443e2ae85884e193e4a78de74a94f01b6"
    sha256 cellar: :any,                 arm64_big_sur:  "d09a0599ac4d87b94f983681c5da627bf90a8b9cfebfafaa98cb9a7855201bc4"
    sha256 cellar: :any,                 ventura:        "f238b7c28336bb4fe982212a323798589c9c70dee1d8fc663684e453ba97770e"
    sha256 cellar: :any,                 monterey:       "47b8c0a42fa0348f83cdf628ac926b6cf5c7590fe19b0569dddfcfb88f9d3fad"
    sha256 cellar: :any,                 big_sur:        "398d8e04376c01600aa2b9c7518b0557b58e648420da2ce921f3c12813822f09"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "edba63a8e74c4022c17ef04440b73e121ffb0502d8f4d7804adf1e5424c67f76"
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
