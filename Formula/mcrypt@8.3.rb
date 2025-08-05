# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT83 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.9.tgz"
  sha256 "2a9ef0817d3bf677f6d7baf8e325629a2758974735d8abad6566384788d424a5"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "73ae9268e3098030e7620021382318549fc8f97531d74e7ee5ce13aacd52d3f0"
    sha256 cellar: :any,                 arm64_sonoma:   "7d0836b47ce9845a0769bf7f9d0a3f0a8ea47885ad2eb9769b78a8cdb237747e"
    sha256 cellar: :any,                 arm64_ventura:  "159357eba8220e42a9247ac66ea180e0d4af427b16da63f698a5890e8530860e"
    sha256 cellar: :any,                 arm64_monterey: "5088db76e56213f685d0541cd82b17ec09edfa38ce51fe6d80fbcef64bc1eec6"
    sha256 cellar: :any,                 ventura:        "1de921211029848b318271555a258baa86d0941e5a32ab5e4625a884b503c2ea"
    sha256 cellar: :any,                 monterey:       "c77ce346905f7da43f6371cc34b5bb7cc02d9c7f50d93c5219a62f0750469b29"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "c0aecd12570fb692ef79619721b45fc571439bb8811bf79272baf8b7aded2abe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c894693329b26e34362cf6e59d29daabe84da05911838bde49f7efb69ee8836e"
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

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
