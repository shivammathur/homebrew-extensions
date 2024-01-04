# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f6db3727459a649d4d9912ce3fdcfec95fa6ed02.tar.gz"
  version "7.0.33"
  sha256 "0e8ab03aaad5a113b693ae3999f7ed7c750b15a514714856840b0ede3302c5ba"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "f32e4accc93ca9ffb38bcd9f11a6987cc1ca3df18bd1f745685366fc52829a7f"
    sha256 cellar: :any,                 arm64_ventura:  "72c911ebb7d9879942410fcebd3f21f6c536bb478ee8a0512fa15086f6a8f83e"
    sha256 cellar: :any,                 arm64_monterey: "c27ffbbfbb12c54af9e3a83e59dd18e1b125f14565b3f423bdc394ba0934d208"
    sha256 cellar: :any,                 ventura:        "26f5d0a74847519947216eeed7aaf55f71de86f3d7a85f26f25eedf3455e644e"
    sha256 cellar: :any,                 monterey:       "344a2d2c4fab43b1ee4e662eae390eca238f191e93f0c8c7e5c9d7d3dbab7d85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b01461a7ab2cd17d373c810fb8fe6c92de6e7b250fae05f33cb0bd7530dd5e5c"
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
