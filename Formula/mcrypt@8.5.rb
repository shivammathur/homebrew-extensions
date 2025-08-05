# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT85 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.9.tgz"
  sha256 "2a9ef0817d3bf677f6d7baf8e325629a2758974735d8abad6566384788d424a5"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a6673db190db44639a353bd859d5c678370aff3277bc07a10aa295939d6096c6"
    sha256 cellar: :any,                 arm64_sonoma:  "c07a58c389283b8031c601a53dab4884050bb7e8912fe89e7c615ed0384dfb75"
    sha256 cellar: :any,                 arm64_ventura: "3623b5ed11e07a11e81cd34182354d508d02567ce3fc1a9df37c236b39b1c875"
    sha256 cellar: :any,                 ventura:       "591000a015afb3cb560c7470259ebb02664223c59a40d4ec8a467e76ce6db4d5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "10126c9d2e3ae642f8415ef439e24db0fbb3115849224e36a7942b55afc40b1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72640288df29b53e88012f60144a41f47898347ea75ba3e50001b9f664b4bd2f"
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

    Dir.chdir "mcrypt-#{version}"
    inreplace "mcrypt.c", "ext/standard/php_rand.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
