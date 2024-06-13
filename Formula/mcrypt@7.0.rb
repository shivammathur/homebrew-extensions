# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a4ea0fdb28141b4ca8c902d7dfceea9b435fae33.tar.gz"
  version "7.0.33"
  sha256 "59e7a3a8c00e063fbc4c1698824751b5ccf6e9432522347073cd8edb0c9ec98e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "77b92fd9e7e3fdcb36de189f1f1348078fd494625f584eed0bc25091362d5d9b"
    sha256 cellar: :any,                 arm64_ventura:  "040477abf67f97b7d816f7dedfab4203a3e680228f1094f5faba6e2512769c70"
    sha256 cellar: :any,                 arm64_monterey: "940e4d655bfb63da1f448f8696890b653ce2e72ab8d9244dcf0b2bf271be472b"
    sha256 cellar: :any,                 ventura:        "e760b28b7a99fa100659b402486f6cb2e007739d20d8e34aba973a34974a2d13"
    sha256 cellar: :any,                 monterey:       "415494adb5499048b7b5d58e7e5bd764b8f87ab35bbfad4a65bc2143f1ba985e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49c8f0d31f1222c6d35fcfbbfb3cc62ba35d75bb4610a1bd67268cd03db63faa"
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
