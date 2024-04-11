# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/19b4f1903d39f6a8919a73b7d1c0930cd5d89c72.tar.gz"
  version "5.6.40"
  sha256 "f2bd7d6fdb7dee449dd694c3ead14be7ed0a2d0464f39ec55786354a28c81d6a"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "60ff30e14f430f8477d41b228a85855d817a86718c2b78621a3c9b35ba237df8"
    sha256 cellar: :any,                 arm64_ventura:  "560354ae975b93dbdf0a3330ca3807e296641b60ebe3a92f70fa77bef3bc207b"
    sha256 cellar: :any,                 arm64_monterey: "6e1a3db59ac545d4b70077fb5c27f89cd02bc49c56e9f3d213b92306708f103a"
    sha256 cellar: :any,                 ventura:        "2bb65bbb6ba9d750b4d4cf48583b8dc28c30af902b5f3aeb1ccf9a8ca4c375f5"
    sha256 cellar: :any,                 monterey:       "4cd857e489eb0442c8c6822725d1b392a8bdf4758f7677bd35e2feb7dbb3a93c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e4dc958de39c25a906a0c01526c657ad34c971f1b9e93548ba8d00b52d3ee4b"
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
