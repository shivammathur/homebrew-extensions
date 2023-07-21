# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7b23b9111203a96db10f8da71dccb2285d872d8c.tar.gz"
  version "5.6.40"
  sha256 "f63340f5ed259c1ed1efcc2c935dee875c77f2ffb778bc11ca2572e099108451"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "15a429b876d7c257cea787fb9f3fb6a6b6784a3974061d7a8e827d71cd7cb5e3"
    sha256 cellar: :any,                 arm64_big_sur:  "5cbb247befe43c32b4ce2089259f8746fda336ad68fb06d0869cf281cc91ed9e"
    sha256 cellar: :any,                 ventura:        "f08d19e07d3260be5d20f7c76f3dc978b9d810c1f6ef27c63502d242f2b59288"
    sha256 cellar: :any,                 monterey:       "bbd07add20649a56308986b028d81602192ce214f889fab0408df9d96ed993f1"
    sha256 cellar: :any,                 big_sur:        "84e28142815bf620411ec4dccc6d68d534578fadadf527f5621a31368e9dfeb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "98d89f06a7d492709e8ecdc425535a0973637dfdce4d6072e7b83dbf09dc3738"
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
