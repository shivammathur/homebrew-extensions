# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0b2d7b889ff02945ff13e630654f861fd6d04851.tar.gz"
  version "7.1.33"
  sha256 "18aa3a76a05c2c9b3c8b1452d64b6b31bcb58bc163ce9927f1751f2a8cf81e23"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sequoia: "bcd5ed5e528666e2879529118c66963f953a7ca2c6b383a9adbca32e353a0cbd"
    sha256 cellar: :any,                 arm64_sonoma:  "5a5d3659bbd5a9f9e4a8cc0f3ce1fe654d998b32fc1107be5ddc770c07ab42bc"
    sha256 cellar: :any,                 arm64_ventura: "a0147f796de5f44f49105250f7c44f37e75705e541201bd9ac40bae076a961b9"
    sha256 cellar: :any,                 ventura:       "ee9e31fd90e3f94b13b2dba5fba52ed5f2ccf8c3ca2873ce8aeb1643c2d6ce92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60c0ce61c254bb2cded8154ff6e65a1749ebb28155e67d1126e6673894049b61"
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
