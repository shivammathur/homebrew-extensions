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
    rebuild 12
    sha256 cellar: :any,                 arm64_sonoma:   "77b893a677660fbb5625c3a85145f246f9710319294409f13369fe0f8a82fe04"
    sha256 cellar: :any,                 arm64_ventura:  "7a0c85481d5b3ae191583a8231e9d8fd07c8ee5a5236723f50af138969ead32c"
    sha256 cellar: :any,                 arm64_monterey: "6be945b9836c6312d478febe431636b570127853cb5325d8144b62dec48b1e20"
    sha256 cellar: :any,                 ventura:        "8eab910e3689cde50d81d7b668ad67fc2676609e976bd6024389055be3378c13"
    sha256 cellar: :any,                 monterey:       "e64d143b60b8e65a03acc1686b127124efa893b247db311e6404040b62aec88b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8c1d8c841ec38f5fcc77ee236979996b46a0e6a0f77b48a52e24d6fc62c3c94"
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
