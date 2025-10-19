# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "e02654c67f088f3949806c63c45149a3d46d4a9a73d893637939d05375203a86"
    sha256 cellar: :any,                 arm64_sonoma:  "c343d976f56b80e454ef4c9d6d75c3205318825d6a2380e3006f2af39634c927"
    sha256 cellar: :any,                 arm64_ventura: "3ff579553428d491d33119322564387524c5ff6cddec72ce4ee8523c04dffac9"
    sha256 cellar: :any,                 sonoma:        "846377d06e6441e081c3ebd01538513fcf6192fb1b54795d7484692222777547"
    sha256 cellar: :any,                 ventura:       "2b5f6ab9d66f223d4add9e5d5818459908372c5fd4d48cf8783dbcd955644ffb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1a25b539b1be10017483ff0e9d873b87bce22c2c82aea95e28a7507f3ac140c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "618d11be96f591c1fb367584f6a80efc17e665aa22f93484326de82f84bdf141"
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
