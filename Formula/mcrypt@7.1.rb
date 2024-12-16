# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0b2d7b889ff02945ff13e630654f861fd6d04851.tar.gz"
  version "7.1.33"
  sha256 "18aa3a76a05c2c9b3c8b1452d64b6b31bcb58bc163ce9927f1751f2a8cf81e23"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 18
    sha256 cellar: :any,                 arm64_sequoia: "1000b07fe1bba442188c799a91ecdec1f9beddf80420c34be0cb897ca9052d82"
    sha256 cellar: :any,                 arm64_sonoma:  "cc4df994d9e705baf5b3a9ee10f440cffd44e9004a735b3884706c128b5ff0f8"
    sha256 cellar: :any,                 arm64_ventura: "b7d0a996cc9c53e648d52478fa93dd1e49b2e198d83af6d80f5fe57df814f0b8"
    sha256 cellar: :any,                 ventura:       "c87dba349aac2f039e3f4183d36f39ae12cebdc7af64f72c33b7ae4a21446e3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "541798ae37d999e41f47ffd5ae51b83e7de2feeca0fc719f7af04ef052f4214e"
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
