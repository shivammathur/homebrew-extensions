# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "a6e9d485a7d36198b93faa92fd9c5361d4bace2e73a160e64b18d2e7cde57d24"
    sha256 cellar: :any,                 arm64_sonoma:  "39b22f7c49d40e94b30284dae8ad7b364e05bcfed68cedbac190da9806d89099"
    sha256 cellar: :any,                 arm64_ventura: "d1d8e641611f0dbecbfe11b815e657cedd9024a416108745a5cacbf337959f8b"
    sha256 cellar: :any,                 sonoma:        "fdf828f180c9657ea35412da47ae9182cd03bc52421de18fbec93379a0df05f5"
    sha256 cellar: :any,                 ventura:       "b315fb24de4fad9f3683b1ad5d71ca2a9ab1663f8a1b8cf8db56c3bb4c05bc2d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dbfc54fd20599364def1bb74456f914f677a29f716c3e6c8447ccaf7a90cb52d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6701b08bedc064458fe898334c66e55c0a029ac4b7da9a5462d0482335567185"
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
