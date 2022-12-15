# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d4ca691b6d9f309b8bf22a55e423d2917f765b8b.tar.gz"
  version "5.6.40"
  sha256 "49dc98dda388ae99e6542b0b6d395c13b58f0b35398b61d0860315e8b1e54988"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "55a9f2a8f85c64b515425cd607092b1d13a7b69ea37363584c4f4778de9344a8"
    sha256 cellar: :any,                 arm64_big_sur:  "ee0858b9e0472e12c2aeef672799276b6048b8a1fd52a04f0b6c0b539cab42d5"
    sha256 cellar: :any,                 monterey:       "eaf6a67d5ce9464628d8aa31f5377fdd5feabfd4d456bc4aae4097561504fd9b"
    sha256 cellar: :any,                 big_sur:        "dc0d644070defde6865930311167f54ad8a7a94ecc4d2cbf4b6e888e23986618"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35b236de8ad242d632aaef09c37d8330aa3c9a1e250cc828a7b976db3eac931a"
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
