# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "3790b7b6bf17a721f9a61b98f1ec579689382b2886bf8a74cf8f32367baa204a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4152c39bf9594c822113dae0d098d64f706383623704c64a5d2dd91072988345"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "30f02c8bdf795df9e36015d0f1ca190a7cee6d9a1b493dbb31e6220225de2cc7"
    sha256 cellar: :any_skip_relocation, ventura:       "7335b8d929adf7f55a7247081621c7e8df34bcac1384d0a52d0545f9f64a6fb1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1003ddca2f82de61bfb7f6e2127fa9cf9cf40bcc2a33521d67cd5151fc855066"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7e4c961e372a33b7bca6cb73590572e703690a7d2583738ca66324fd75ca2b4b"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
