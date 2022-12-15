# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4b17f6eac40a9969731963a28476160c833f8a88.tar.gz"
  version "7.0.33"
  sha256 "066be6065d88946b8e27c6703941da124903fca96549d950ab6fd4668f4bbc94"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "60396668f279ecbe3d7482151f9e92578d3c4053633caa252be75be7200de171"
    sha256 cellar: :any,                 arm64_big_sur:  "f47b957f424ae8f9f80541460dece72d14f78a24bd91d37d23c020adf2f7abcd"
    sha256 cellar: :any,                 monterey:       "8e1422e1c02ff46671ef87313b247387df93be0ea44432f1c5d97ae7d2e1245c"
    sha256 cellar: :any,                 big_sur:        "19b7b5a46a67086d5789c389fe25b928b828f4105ae63bd76d0d74939042c59c"
    sha256 cellar: :any,                 catalina:       "375be34cb3e64b813aaff7a03484362ba4c4839f21c0ec7751900ce0380aa113"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8273a84f0ce5c82dc60cf3cb7098f4e3339b0d92dd780d582066368f81510e70"
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
