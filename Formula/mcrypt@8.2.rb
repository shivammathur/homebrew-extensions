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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "f4502db7c3116a68412328c783bc1f92158f6eec73f60193de47ae738f60045b"
    sha256 cellar: :any,                 arm64_big_sur:  "e57c78fc2e0cd2b24cdc702453c5445b7bd8c84026e960efed04a91f71e0a66b"
    sha256 cellar: :any,                 monterey:       "847a4bed9fe661cab8e33b3fcf5f724cbe52385cbc5ec347f9f822aa1e01b500"
    sha256 cellar: :any,                 big_sur:        "e76e4d40a33b3a57d4ed599ae9334393acd3349a16d9d63b31c948b9214f6c46"
    sha256 cellar: :any,                 catalina:       "558e549d90f2d0a1758635adbd7a218c61d7d71c747cf45b27ef7b78d1c3e134"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2daca517c534a00f1eb05ca75a48789a8f27c0e0f9b88bddc9dcef192e476c8b"
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
