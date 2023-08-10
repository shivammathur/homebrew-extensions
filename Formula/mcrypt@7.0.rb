# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/745b6220ed05d9a4a3302371b8d2ceb9ce7c287e.tar.gz"
  version "7.0.33"
  sha256 "3c7b35935e47d72e43cee7fcff2252b37000819f512235c6b314b184c588329f"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "e53275abfce7962809c17bdbd764746b84d1ab4efc32392bb9b9675696f9b36b"
    sha256 cellar: :any,                 arm64_big_sur:  "1220e5ae5bf7d39d7e4cf3549ddd5dfc679849aa2cad6c1d9d850309c12680fa"
    sha256 cellar: :any,                 ventura:        "37337f2d427b4a0178d5972f7f29c30bd15bf516dcb1a1a7957ac81e3080a5e1"
    sha256 cellar: :any,                 monterey:       "3a4d23ec54f5442f05b011492ae4acf3f4041c69db7dfac46bc875c389fa61ca"
    sha256 cellar: :any,                 big_sur:        "d5cfe24509dbd6f93aad728ddb5816c5a8607e052a091c051a241db64b07ea7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7882b513574adbadead578580f35cf446830def07744383c8caeee8ba814c0ae"
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
