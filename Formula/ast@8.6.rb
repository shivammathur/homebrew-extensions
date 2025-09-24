# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT86 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.3.tgz"
  sha256 "528b54aabcfce6bf0e94b5940a73cca357d4a52fad9fef4cd4dc025abc1a9fbd"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9f7670e391a3bb3215d36adc6d43c5c18fad3985b581fd4a67a0487fe44295cf"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a914f23a1191babd784c1d2395d2c2e8fdc10efe120b7d31c61081c3807d9a28"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "19ee7b0ed91baee446b190c9e34384771dc8a17618349af35ed8030fc3166c07"
    sha256 cellar: :any_skip_relocation, sonoma:        "f47698898b4ed9fd9a7fa0f22eb1ad0a68b3704e197315213b83d5055856bef8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d61f5c90358424a501af52b3a1030b86eed5ab88e6bf1303465ef208de067fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e3d8e5bfc1db3bf977ead937d9cb41804e1ee14de29c34b58bbc439bc0c183d"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
