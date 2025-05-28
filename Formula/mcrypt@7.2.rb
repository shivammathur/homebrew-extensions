# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT72 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "e9aa79b9fb4a53dbf4b8d16c45476d64c2a65d76ee6a7418fafa032c0c2d96f9"
    sha256 cellar: :any,                 arm64_sonoma:   "49c6ec63abe2db72ea76609fe262b6323ef4d93732a5ac89e5ab6e9b9aebe3aa"
    sha256 cellar: :any,                 arm64_ventura:  "f7f7e669b5653e31bc425e6b2c3687191a34b04a44604691517ed8858dc4712a"
    sha256 cellar: :any,                 arm64_monterey: "83fd3a2eb2722475c0b69f34e619eed4fcadb0bd3927e02c18b1ba5414abe349"
    sha256 cellar: :any,                 ventura:        "1574d480fc7db3632428248def63cb687a5fe6ace06a25f5347d4707d3e6d77d"
    sha256 cellar: :any,                 monterey:       "cdfa2802d3e15d4349eaafa23e21f768f57301e2ad25ede05415838a851a0b06"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "0d67321af5721e01a86aacbb94f8fa3001f43769bf89dc5442420eb74ce97a4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01dab7a2c8739b6abce7579fc1a116bf1668f79b723ff519133229720c304a17"
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
