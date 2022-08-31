# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
  sha256 "c9f51e211640a15d2a983f5d80e26660656351651d6f682d657bdf1cfa07d8a3"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "42f6541e0421f814644a66ead8250161947a3dc41a63132559a5b483b683a488"
    sha256 cellar: :any,                 arm64_big_sur:  "61168a552e6989586926deddc4e54853a15163efaf08bcf6c3b72135c8e23669"
    sha256 cellar: :any,                 monterey:       "d21a66b5e24ab097961130fe9d543651ab8b151b9bfa6e16ed94695432c9fd86"
    sha256 cellar: :any,                 big_sur:        "80048fdcd2884eedcd4b3686380a6b5971f4b9d179dd3164a9c2ca882077cf55"
    sha256 cellar: :any,                 catalina:       "70d44449960d0d4af70f188d083e2ddb87054d2a996ed0bf93e8478b4ff1a721"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f9ff0cfc7e7bf6750ae84517e4962ec852b1ebfac699c78946f46b39ba4f23c"
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
