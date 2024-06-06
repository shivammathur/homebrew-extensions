# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f77964ef49a459f67561517cd77292ec505a03f7.tar.gz"
  version "7.1.33"
  sha256 "f4e0826d2fe16ae4dc9d6b7b54a0c24488fb1b66c8202f8a0c27987a9172ec61"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sonoma:   "bb4891ab1e729c1a6ca1deda4d8e312195fcc8f959d21f9eb23ac4209bc90e16"
    sha256 cellar: :any,                 arm64_ventura:  "d60e61328e316bacbde753e5bcb4f88fe36763225f016b690bebe8471a645221"
    sha256 cellar: :any,                 arm64_monterey: "cdffd0a79918de570f5213b0149b2586307e2d81b67aa62dfa179ec70907b157"
    sha256 cellar: :any,                 ventura:        "e397993d818bc2d3b2832c560525291980eeeeba9eb068ca7c401d587cd11118"
    sha256 cellar: :any,                 monterey:       "9890a2a12f875caee26c0a4f68cf560507f0c324c911b56c0820a90687ea7ce4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23a878adc1c19438d537db96d5aae397468cdd92ea21ff93e6c4e4b114bfed04"
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
