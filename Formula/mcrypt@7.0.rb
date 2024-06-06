# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a0ed4659614b301396ac13d798a9d3bcb798888e.tar.gz"
  version "7.0.33"
  sha256 "d5c3fa82540d67f656fb4d90bd2b420a323e61319ae4d25d66080d1dc4f413be"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sonoma:   "5d8139f8d2690787b06cc0c725b620f3875900381b5de254991242474a4cd5c8"
    sha256 cellar: :any,                 arm64_ventura:  "23167b9a21f3a52c4b7ba63944da59d3aabad1e01cce1ef56bd325fe35250ba5"
    sha256 cellar: :any,                 arm64_monterey: "e96633051a4dc0b0fb76a2983868e81e535ecb96b96b125d35d4b2c0856843bb"
    sha256 cellar: :any,                 ventura:        "91ec5045fc60730fd7548027763e1a11303899b6f89d659469d3fbaa83028d3b"
    sha256 cellar: :any,                 monterey:       "7287947c6532b0102f9adb78841f50554760cdb433c1d321e9f138a4812158bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b120cb8b8a12eead8f0d91186a1edb2fbd3575e94067a5e0f74fec2945fb4b94"
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
