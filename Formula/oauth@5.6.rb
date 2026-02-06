# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT56 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-1.2.3.tgz"
  sha256 "86bb5ee37afe672d4532ad784c7f711855c79f0dabf0acacafd5344ab6cf0195"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c86b84bd6bb13ca95d33ad5634a46a6a1f69a65a2fd430a64550c6358e609881"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "aaffc27b98fd0c39ca3ea78d73727889619b9e68be6ba2ba86ebab0d0e4ab1b8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "df06e360258a76e1d0af55d9d43a5eb6cf32b40a6338484fb0376cc9605c93b8"
    sha256 cellar: :any_skip_relocation, sonoma:        "e1059970b4a42e899d3b76fe7a9a41ed2680d1358b1d7031eca0b176aa4a4b4d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "af51ec130a8729b1337fcd0c92927c2f351e065b56c9a99536cd35bf8982799f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13f84cffc23dfe5573724312c9061166992fa92a68839833309c19c5aa9fbdcc"
  end

  depends_on "curl"

  def install
    Dir.chdir "oauth-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-oauth"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
