# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6c34dd8846d13d06f91a0d1b61bce9a941756831.tar.gz"
  version "7.1.33"
  sha256 "bd305498a5ba9e47fc60ea94fe2bb552e0833fadf04844a17bb68cc75d46eced"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "2edd33014b47387c8fe591331a37350bd13457909b431a2b59cb77abb6b0a28c"
    sha256 cellar: :any,                 arm64_ventura:  "47b47d68d6b7a706143bb5e6b76bfa4cb5133cbaad7931eda5a6f811ac02bf54"
    sha256 cellar: :any,                 arm64_monterey: "2acc2e820a0d2b13ada934645941e4428fc2f584d32b100951e0e4405f801b53"
    sha256 cellar: :any,                 ventura:        "e209432155e06f9ee550501d14ed8618443ae34cf5f91afb5eb6185bed6c7837"
    sha256 cellar: :any,                 monterey:       "8b59711b2e22917f56958d8aca1d3b9aea62585393bdbcd096402914e5ba308e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48e34ffa879ff68386bd6fc59ca7285c5eef25f111ba395874d84bbeaf5410d3"
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
