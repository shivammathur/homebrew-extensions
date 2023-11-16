# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c3e4317bca4ebbf150d9ac5dfdda8ccdebe4dde413c2da5a7e94e93924781f17"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b9c201ceb68a8308cc926a4f58b18124f3bec9b9495c51bbf5102a9847540caf"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0fc8e771a19099244c3c09bbabbb378756c725c0c1e1505d68a2de66ac9f1811"
    sha256 cellar: :any_skip_relocation, ventura:        "20273cdea4c339b3907319360a28602c3afa98da3871e532d7a0115fbcad727e"
    sha256 cellar: :any_skip_relocation, monterey:       "571b3466d51ab11a6c8f064c33dcc7c7c4a507dc7bf30a4156c077142e14ffd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "33fcc2f8c6a7b392fcc4128560563ea4e06a7a9e5713c82a2b6ea217b8dbe6d3"
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
