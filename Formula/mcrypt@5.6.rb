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
    rebuild 7
    sha256 cellar: :any,                 arm64_monterey: "1f6e5cb90b5f417f35a0d4a1dd085ab5d74e4e7344114b40af8ed1787f93b7ec"
    sha256 cellar: :any,                 arm64_big_sur:  "adc458b9dd6db667d7b4dbb7eaa99bafff2ccb734069f1df013dcf4c3219810c"
    sha256 cellar: :any,                 ventura:        "cda2339b8fa77f6f51f9d0a27c804fbae3bb0990b8bc987ae9457a3c4aa0da73"
    sha256 cellar: :any,                 monterey:       "157195edaef9a27ac63d89f9ac917d14198f14e25de6734c145dec2779041e1c"
    sha256 cellar: :any,                 big_sur:        "c161ab529b6e06b4c80c398606eced9d51d4309f66e1594505985f17a70d643d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b09426ab5ef2b9a554c9dfc9dcd7a40ecd294b919085cbe96682bc80baaa4ef"
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
