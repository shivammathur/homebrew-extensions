# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/02fd32ea23999fb0ba3e8086c4f1619ef1647182.tar.gz"
  version "7.1.33"
  sha256 "9904d725293bd177096e549ce4f0c846bf2fcc62b4405c8fbf8af313478b0065"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "30db6f32b811ae7c99a5f66f4efcd603859ca151b84d5f379d3c89a6754fb25e"
    sha256 cellar: :any,                 arm64_big_sur:  "e788b481ffecf858d0f60009a9bbad7052074b7400af7683a1e7b9421d45937b"
    sha256 cellar: :any,                 ventura:        "4e64603c50a8195e2a4f4c0f1f95a3b0205ae6e6229061f3ec207a552570be8a"
    sha256 cellar: :any,                 monterey:       "7edc12f6b0f1102d397e8d52181e5ddfbd469036834557810a2079a1381ce27a"
    sha256 cellar: :any,                 big_sur:        "83550a57aee919d7944cc901901c6c2a3e4369893e6915655c21fccb647a96a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e25dbeedb3574fcea4ec1d164704ffc38e64184263004a92bb01122594dca1d"
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
