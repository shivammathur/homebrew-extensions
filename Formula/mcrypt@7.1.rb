# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any,                 arm64_tahoe:   "b21f84eaedfeec59645cd9d80f80d0a84861baffdcd3b452dbf54a2d467a3d4d"
    sha256 cellar: :any,                 arm64_sequoia: "3d65fd3415563c33fe970aec7549cbf00f1bf79e96c103f1641ca3440f1a51f0"
    sha256 cellar: :any,                 arm64_sonoma:  "2d2dfc4f270353eef304a138594ba26a0bb66ee295fa14574219a9f8f8026858"
    sha256 cellar: :any,                 sonoma:        "24cc562ca35f015a69e591d39aea38eda09d9d976e42ba34e9fa639361848247"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8ebae0ac53456d406864f8f352aa57eb6ee25ae9e608611a24c7b17dee3c55e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c39ffbfeaa4df030128dec98c7270093373d0de45deca114a6a45b51626d96b4"
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
