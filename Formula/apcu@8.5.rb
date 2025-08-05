# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ce899fe805512838951248583220682eddd35d7d357c33619d04b1f562b27e5d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e35f3af0c2a083fe5083bb2e0c3eddbe9c90c308fde07fe22fd6cae8734c3fc4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2a52a02570e473e8968dbd965be3a72c93beb507878e413a6579a4a07c10d88c"
    sha256 cellar: :any_skip_relocation, ventura:       "7a14b71a533ada80f9cb6707bfe829706726ecd0edce92e6836a64cbb8058b61"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bba783443d57ad0e1ef31d1efd5b589db3a00a45c357287818e098ebbd4ede99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "43404d7f7f620b87504ae6ed89c6c041aa4197083ac7201513b5a57535416268"
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
