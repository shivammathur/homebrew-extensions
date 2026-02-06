# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT86 < AbstractPhpExtension
  init
  desc "Oauth PHP extension"
  homepage "https://github.com/php/pecl-web_services-oauth"
  url "https://pecl.php.net/get/oauth-2.0.10.tgz"
  sha256 "1fd5e074dacf5149603493c454b476d69850bec0a71d7ea69a36a00db728a0fb"
  head "https://github.com/php/pecl-web_services-oauth.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/oauth/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1631dc86ff1ac2259bb946a5b7d3752eca9dbeeb383f22d4038c24f5db21f769"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "80f8b532f5ac3cfcfe3818f587fbcea79eae0aca72c35e9bc17763642b711653"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4d11a59cfa447a44da369461fd0bf2d5a1bec2f1027434704760cd5cf9dac6d0"
    sha256 cellar: :any_skip_relocation, sonoma:        "1487a15f1532c5651c0afd04772319f6c4c05d889dbbbef8740d4bd2ea68872f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "caf2dcda0f7648a256264bc1ea69e962ea2d46bad738b2e027cd211bb2a08700"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21f278d2e70d0a719961bc44da711d79c0e2e64ea3d6881c645972883949b85e"
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
