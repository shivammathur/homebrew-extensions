# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "51a4d78716dd27219e1791a3381909bc7599898074fb31ee53dd3606d4d229b1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c8f19f923cde41f356336745ecce5747bbc4f1d2c428860758d1f7c6cf838d87"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b4e640d40690ae473e1de6cff225f760d085ef04744bebca238f447c2fda4a9"
    sha256 cellar: :any_skip_relocation, sonoma:        "31310b48345699080f9396078ad37e6faf1dfab1bed1e86bcee1e960fa56616d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5afcf592834ac243ceb6a6b459b0678d3e4a248d617aeafc65e4cbef3223386"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6cb6bf561645497e29a3a079e09ee2c59b5431a697834f207e8ee88cbaf50233"
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
