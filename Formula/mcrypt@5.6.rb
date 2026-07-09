# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/241845d24ddbbccddc9be4006c103d9ddaf3b724.tar.gz"
  version "5.6.40"
  sha256 "836bc6985113313d2a9cfc14864f9506b0c752c24cc9bf0a66454e890921b9d5"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-5.6-security-backports-openssl11"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 21
    sha256 cellar: :any, arm64_tahoe:   "fb54081379cfc595cc45424e0bf84d908a45cdf9ca879b0226c1feb5aaee5595"
    sha256 cellar: :any, arm64_sequoia: "bce18943f12347710fb1de73fa081844d952ae6d8168e303d4634f2381c42578"
    sha256 cellar: :any, arm64_sonoma:  "75b670a398554b03a55ca0333b9608e771b19e436b10bcf91574e62ad83bdbe4"
    sha256 cellar: :any, sonoma:        "4802b4ec1f22ef4b64ce1d855f1d486b6603b9687c4a81e77a83e846493254b9"
    sha256 cellar: :any, arm64_linux:   "f477803ab14c2ac96203407c0fd85796df722581f83e96cf5e471f032fca32f7"
    sha256 cellar: :any, x86_64_linux:  "c7c25c995ea3bc15c2c91e518c3181443786dd572122b9114ab4d98b15956b75"
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
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}",
fn
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
