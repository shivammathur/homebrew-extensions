# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e45de435814feddf8e857aeb8e08fe376c5e2b2e.tar.gz"
  version "5.6.40"
  sha256 "9b23f30cb472afd0f48891abcc22a5ad3851775e31014d9169123ee98db49945"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "7199e2f4e75f74f3dbc9f83625aea9732d1da10d69345b97b9b8345d8349c164"
    sha256 cellar: :any,                 arm64_big_sur:  "a3b15ef1efaf4badeeb419b2dbd3e67af19153a136b6d07b462fea1f1873aba7"
    sha256 cellar: :any,                 monterey:       "35a8384cdb2314e11953fc838f2673468c2b176037b7a8378e6b0e82a208de75"
    sha256 cellar: :any,                 big_sur:        "566d420457e4dc54bdcab85965ceb24f75c7b847ef8b17aa350412205308561d"
    sha256 cellar: :any,                 catalina:       "e87f6d026969cea89da14f1e791c3184da9bb93ee3a686e10d77e9bb5cbbe58f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fd4ee48baeb868be8f8c879ab28f561ba27cc7e2d036c37a17dc44401650ec3"
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
