# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/db1e0280ac104aedda87b64fa8403a8665af56df.tar.gz"
  version "7.1.33"
  sha256 "e211aa6626ff03b352bc1ba3556a71129fd8f94979861e4991858bd9f6e734a1"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "62446081ba2c9c5671223c936aa869c0b8fe50945ca313a427cf4fe29e4d37e9"
    sha256 cellar: :any,                 arm64_big_sur:  "d45382de543e20abfca3f399560a8ecd34c97f669503fbc4f6f41854dbaa2994"
    sha256 cellar: :any,                 monterey:       "2b659dc8c820434cccc5f2760f8adbc2bd1a0f9277096a7bc19516f599c75fe7"
    sha256 cellar: :any,                 big_sur:        "55771ffc89eac52690bbbf97631dce6c920ac94c73aa9b254b48b9ed8104c343"
    sha256 cellar: :any,                 catalina:       "4c110c7918398b53b4a37e95c460f0457a670c0cfccf2dbc804d2c13b5891332"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31237a63d9f02037ea5d6ea85c48841413bf0702c05494bdb9aca11f1756898b"
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
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
