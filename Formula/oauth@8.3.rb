# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Oauth Extension
class OauthAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e8cea30eeeea92275462c762274a334311471dc0951dd9b863c572234d40cfcd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f12b040a505273af12257e5e06bc57c27988d8a90a304e65023fbdccf799b39c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "830fdd580c34fe96eec47ec4b577663676925305fd9ed0c392e0db5cf6a758ef"
    sha256 cellar: :any_skip_relocation, sonoma:        "46479ea788df6b75d1fdb099890eb9a2262596832116473c822e9e8f88268efd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c40ef67a223f41dcae0e86b9e25e5c380e995003a515e5a9dcaafb6e3e3d7dd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d42ab5314c424015e8570fd81fcfad6bf5c8373f32776ff9ec822b8328f77cdf"
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
