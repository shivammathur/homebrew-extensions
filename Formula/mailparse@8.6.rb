# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  revision 2
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5b1d80b38b57ee0d825e88f704729f57d5a7259a447209e9553eabd10aad71a6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ccfc23270245938c089d607773d6eb7fbaae15f60be418169630fae77d39f088"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6517d5eef18883a9250b71f5f07cb6bc8d5ad45414e9238626f9ebdced6e03da"
    sha256 cellar: :any,                 arm64_linux:       "3c341420bd36d3f86f80adde2a5e4fdae722c2867abf0f94e122905412b1609b"
    sha256 cellar: :any,                 x86_64_linux:      "bb8b6963c981f561a8e6cf531f50f86ba19ae6fac2f82c32c2f12ba4ef68581a"
  end

  depends_on "re2c" => :build

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
