# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT83 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.25.tgz"
  sha256 "c4e7bae1cc2b9f68857889c022c7ea8cbc38b830c07273a2226cc44dc6de3048"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c3dcee5b7e667d1a2e1ee975ae6f9ab21b100b98b0f94ad9260c6268d3a9d624"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ecbae650e435e1b202fde91f0d2ad66efe063736e71145cd26e82b1008aeeb63"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "055afb3422025d1905a61837c071acbc46d996cede0990061f944a7edffcca25"
    sha256 cellar: :any_skip_relocation, ventura:       "3bd317c9e36673cd5e03c6c98fb864270065019c8dade5dad5143f570fd6e294"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1260961d312c3e8c371062c392a5e009c692fe3f569a38cdf4b4c36390a54aef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5519622548b6ebe04cbfa82ec0265ebcea14757fc55af917f7c4dc374baedd59"
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
