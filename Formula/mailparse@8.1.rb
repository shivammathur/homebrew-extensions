# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e12a86e4068cf6fe522531ad5aea34df0f7ad7ec660d0530b3db550c01bd484f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "03eda6c9f76993b08810665904e32531ed31c7cbaf6f58857ae85260f5d9cd0c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dcb9b3e813da49499f33159e69a0b7bd0f8f9395d8f99d9702108efe69d2cf2f"
    sha256 cellar: :any_skip_relocation, ventura:       "c3f4dc7a469c6cb6ba2049e250177ac03a613b5110023dc3d8cab0537ecb1b9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1605440b7424765262a4d0afe9f9d3ac16d3dc68762e583e32d5c3ec1a54de5e"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
