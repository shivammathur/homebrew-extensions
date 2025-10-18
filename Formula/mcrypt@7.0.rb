# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91f3b4e4ff74ed2432010dca9ae9ce5de781670.tar.gz"
  version "7.0.33"
  sha256 "2d80d4186c14aa7e75cca38105359eda808a512a57824462e84e96d5b1be6b5c"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sequoia: "d5606305dd81a3abc40bc99a804d44d7579c7db861590307e981a218b247a889"
    sha256 cellar: :any,                 arm64_sonoma:  "6b7c5964738778048b2c3658ea32f5d49f5bed4b900a4974a2801b818c5e5ba4"
    sha256 cellar: :any,                 arm64_ventura: "444a90a9fb9b605d41c4b85930974077f147587738797b695827abf3e0235757"
    sha256 cellar: :any,                 ventura:       "14d2937f0e3ff93c19541d4f429c0cec2acdaa77613ce8fc01cbb7cb61514340"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5e21b1ddc10da342c81f7155dd6cf1426ad36df6e64c72fde371a91c927b788"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3be4696502ce1a519d6c65811e7def06e0b94bf7d5f676cc14886ce6009cd5f1"
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
