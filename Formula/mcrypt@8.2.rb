# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT82 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.6.tgz"
  sha256 "be6efd52a76ed01aabdda0ce426aed0a93db4ec06908c16a5460175c35b0d08a"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3db17198e5f4830e3efee847a0b9e217a371ec831b59e2e552fd9bbc2fd00491"
    sha256 cellar: :any,                 arm64_big_sur:  "e37c35878322855dc25b54c08631ce2000bba97d71db83ce03790cbcd439131a"
    sha256 cellar: :any,                 monterey:       "f3734486200581d33ebc57ed2bcfaf77b033972040a9344c5677f856a229103b"
    sha256 cellar: :any,                 big_sur:        "bbc597ef8ae6408c97b252dcbf8b57336180c8487cc5c3f4bffc6dccfad5e423"
    sha256 cellar: :any,                 catalina:       "a3bc3b4668e835afba19b820cb1b87d8c7c21cd3ddec28d60be6945704b5dc13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "801242988ae7d8c35dd861ffc0ec31b85dc7291de76bc2dd7fe5504b25ac5845"
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
