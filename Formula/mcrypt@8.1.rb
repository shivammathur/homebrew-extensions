# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT81 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "b2aa9ed0f651d9a0818d9034e21553f5d319e9e7b830d72f381616b40f76c19c"
    sha256 cellar: :any,                 arm64_sonoma:   "717c500ad4f5853d134f09d4734f5131ab5dc42e2c7848c92dff440d91daf6d8"
    sha256 cellar: :any,                 arm64_ventura:  "b68db7684ea95c0a75a0225f152e4dc7d1160c1a7ee52fb23d282cfbfa920f50"
    sha256 cellar: :any,                 arm64_monterey: "b14e2bc24c09e6dc4cf93a08942c6c54197b6f4ecaa7b13e67e253cb3fc00d99"
    sha256 cellar: :any,                 ventura:        "18a61163d7e35c620eb26dec2e62202e62c7bfb198eedc9ecf87d4b39e2c7a3c"
    sha256 cellar: :any,                 monterey:       "5ff62bacf6bf46d1a1ee90a64553c56cd344e3f90f9d021e161e46dd5d601903"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "e9a579fd7447fa123419cf9d710a023c484cce100ff7a06905d3956c93466965"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "968f05ecfafb7820bd2c42f2c016f9594dbed9fd374bfab4b7e04a88f57e9edc"
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
