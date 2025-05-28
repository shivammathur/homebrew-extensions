# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.24.tgz"
  sha256 "5c28a55b27082c69657e25b7ecf553e2cf6b74ec3fa77d6b76f4fb982e001e43"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e713752219d723a019f2f69b6ccc424936d9cc7f5382f1b7678049fee072a140"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "06ad506dd362bcb74d40a073793849d08736eafcabbfb9fce0fdfe7828879837"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2f7b8643b36a52f730786e0825596ddacb1df033c4c0a73d837a45c1a6e86920"
    sha256 cellar: :any_skip_relocation, ventura:       "b699a1805cb7599b4367f79a2e34e31cefa3acf37b711a271ac9041642580ed1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "241425a4be643b4d3e364135d4ea54a5004981a2037f9a306e5302d29d7a8817"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0a7e4eca8e4435577b1adae9548097be6f079c57fca1084c20b76592179577c"
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
