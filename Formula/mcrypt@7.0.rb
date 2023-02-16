# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/06ccc60e1bd15158ae2047c7e9a151516dfec7c0.tar.gz"
  version "7.0.33"
  sha256 "3115b7d37e6e48c1924c243f79a335ad9c9df770f8b862d2a9536a2cee5d65ff"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "09035da2e8625d19971eb75f417c6bebe6fb2056a2e20c72107d724f6ae0c02c"
    sha256 cellar: :any,                 arm64_big_sur:  "1573ecee76f64a43675a83af22ee75bcd9540dc5bff87bccd81bcb979124ea43"
    sha256 cellar: :any,                 monterey:       "3b2990dac1df3b47903082af4480b2dc7a3c84feb7a8a8fc0c75a6aa5d2ab275"
    sha256 cellar: :any,                 big_sur:        "ef44b61f1fd3dee7167ad50ff68e51d16e7f9d8ee87c40cca9ba4277f5cba216"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b00cef33a611ac698dc7ed92b5845864aecde9d7deaa3e2ab72c0a11696b8334"
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
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
