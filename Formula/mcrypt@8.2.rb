# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "7d8d97d3df4847552510b0458a0396cbef5ad39d69967cc46c2d782a517935d5"
    sha256 cellar: :any,                 arm64_sonoma:  "e608586fd339aeb0c8fdbf2c701498e131ea367acd8e21ac1dcb17da174eb493"
    sha256 cellar: :any,                 arm64_ventura: "c2987b1357700a02390220d927ef873f6b83041e53bf381de565e6a12055f998"
    sha256 cellar: :any,                 sonoma:        "a8c0c2d892b7b18d85202d425a4ac28e9f2b034a78ee675fa95f9c9b1d1c7248"
    sha256 cellar: :any,                 ventura:       "8b3d0c6af5710176d829e14102770c11e47505e7b93d000ba77c322622b5c773"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1ff0942259da3f9c360ed05ece6a57f54e4f97550d57941cdf0ffbbb215df486"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9bdb4e019a9b6dc8448b83804350181fa8c69600bc05b7c95d042d74a51f671d"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
