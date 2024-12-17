# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a39dc7ab765a65cc77b7a7ff2fe3dfe2cbba5c4f.tar.gz"
  version "7.0.33"
  sha256 "4f218a72364843aeceee8e7f170d20775ba2e9ae9fc0bb82a210e9bdd226705d"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sequoia: "d174f4425bf65e2c4ef6240ab29261a44bdc08115b516f644467be36c99a285f"
    sha256 cellar: :any,                 arm64_sonoma:  "ea7104d6fb6cd3196ae0e9aa5ee44cdfd6f984e283868752639d44b8ea15ecb7"
    sha256 cellar: :any,                 arm64_ventura: "5b6c918eee661028c4c9e56ab5ec09ea6f26d3e2d4c187981eb68926a3c6d3a4"
    sha256 cellar: :any,                 ventura:       "52a47a0cf4a7c1dc966ee7d1d4685b33711bf39f653d0f4d6a73701302c3bf37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d4c70db34e9efce7275eae83a6f1d89496bac0df2c378fe871a521a81dd6b62a"
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
