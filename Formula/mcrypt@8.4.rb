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
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "df1bf74002f4b6cb4c21ab8c2fce800c84bcf8b44deaace0f90030d08fe8fd58"
    sha256 cellar: :any,                 arm64_sonoma:  "ec6922bd479bae2398fb28c1075afce738c0639f6df794382c181bc0fa7a1367"
    sha256 cellar: :any,                 arm64_ventura: "91cdf588dcc0f323bb5679bfd82755e1a1b660c127c1d7a7d34c3e2f2631f06f"
    sha256 cellar: :any,                 ventura:       "69d7155f61efa5d5bec17773e7d23417500232c9614755c4dff20d9d118ca3b7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "572b32584ea4ac74aa48ffec5552054d417f15c76dc34d73de7b39f8570ee518"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f1db6e9d9b76fda32d50b4c7ecc8ee445ab3e5b6775393b897f43f4ad6597430"
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
