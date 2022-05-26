# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT82 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
  sha256 "c9f51e211640a15d2a983f5d80e26660656351651d6f682d657bdf1cfa07d8a3"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "2f0f5dd699833ee223482df17857521b3bf33028dee230c2ceee67a4d491c1ed"
    sha256 cellar: :any,                 arm64_big_sur:  "50e20ff3f0c0d028db632f03d24cd4ce666ba0395a5c1e3d507a8e65ceec2bba"
    sha256 cellar: :any,                 monterey:       "ddee0546df79be14b545d75284dc4a34ccc7069b799ebc62a814a94fbac75cc1"
    sha256 cellar: :any,                 big_sur:        "219e6a277d71ef1ddc5619e40812c81316d63318b82c07294dd794ee84fb718d"
    sha256 cellar: :any,                 catalina:       "4f206352640fe060c7250ff313b728fd348c63f4017d6f7d0b756e8922a3e6ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3e28168370cd5b88de5cb5d1e079f63ca06c30e3cf1d567246cd596373492d53"
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
