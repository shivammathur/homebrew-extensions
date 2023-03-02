# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT80 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "41671a99f0a106f448e84079f7bd6fedb02019e0202b245de4bcb43bd636f699"
    sha256 cellar: :any,                 arm64_big_sur:  "0d31765cab4b507c450a6659befed4f4002dfe2529c2394fccfafaed5560ecf0"
    sha256 cellar: :any,                 monterey:       "c99e4149ba82a40b57eb447c55443a6ea4fa770f5021a400beb5b834f3e070be"
    sha256 cellar: :any,                 big_sur:        "0fcce58b8b8a17cbd338c94f944b964b4a2a9f93111aaa1b2c146f8c9354c13d"
    sha256 cellar: :any,                 catalina:       "3629440e59b4b0f24d7037cd70420945f561610c15ed3880ba0caa95fc084975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f52526a3315943ad73c8573514db3aa600df320665c63305328cf0acded4abaa"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
