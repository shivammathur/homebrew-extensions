# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "d278e39ca967c57abd1cbe7ebf1e532d8fe6490890ddded53eaef8359cc0ea27"
    sha256 cellar: :any,                 arm64_sonoma:  "a7cf79b06104ef50813a778332be1cc8bc415cdd574bebed7dd9d8eed49e2ab9"
    sha256 cellar: :any,                 arm64_ventura: "ed13a074f76cf5c698a233f81240e3e345b3ffd0ddb34bd053789757aa8c8eb5"
    sha256 cellar: :any,                 sonoma:        "214bcd1fa325bb6ac62b4c901675d3bb309fbb2783b6f1fddffe82f1906cafdc"
    sha256 cellar: :any,                 ventura:       "847feefb2342feddfa7279f31d21503e3d661421e4fdbb834a7dbaa8bbf25f3c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a69d1352066867210e8a7a76cbacc06a9a81d27bd4fbacebbb1e790421f702b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c68404cbe175d2e131496f75114b5b4f57169b570f1c8c448c598660d01d6e5"
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
