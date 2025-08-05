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
    sha256 cellar: :any,                 arm64_sequoia: "f1f9af2c011f5d512fa7928f044fa19217e36715c0eab074cd4935e0a604c29d"
    sha256 cellar: :any,                 arm64_sonoma:  "e46547f410b2fa30d88669bda0c2c626a4c1537d8549cab8c2c10e65a367d92c"
    sha256 cellar: :any,                 arm64_ventura: "dc60e029cf8e3b8cfefae087ab93b8e2b1cc177d536ea7f71511c4065d05f6d1"
    sha256 cellar: :any,                 ventura:       "37fe59578115a8f038504c63962e23bdac286e0aeb279c7550e741979d1a8505"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5fa0c329f94caa2559b3ef249816e0fea8e2a9ab05a8d540894e67120e2d56cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "388df4806e2684800cbf70384e26e7aeafb44dcd4ca670ce3e4756906933ad6d"
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
